module LindaBase
  class CodeRunner

    attr_reader :workers, :path

    def initialize(path=File.expand_path("../workers", File.dirname(__FILE__)))
      @path = path
      ::FileUitls.mkdir_p @path unless File.exists? @path
      @workers = {}
      Dir.glob(File.join @path, "*.rb").map{|i|
        name = File.basename(i).gsub(/\.rb$/, '')
        @workers[name] = Hashie::Mash.new(:code => File.open(i).read,
                                          :path => i,
                                          :name => name,
                                          :tuplespace => nil)
      }
    end

    def run(space_name)
      ts = TupleSpace.new space_name
      @workers.each do |name, w|
        ts.instance_eval w.code
        w.tuplespace = ts
      end
    end

    class TupleInfo < Hashie::Mash
    end

    class TupleSpace
      attr_reader :callback_ids

      def initialize(space_name)
        @ts = Sinatra::RocketIO::Linda.tuplespaces[space_name]
        @callback_ids = []
      end

      def write(tuple)
        @ts.write tuple
      end

      def read(tuple)
        raise ArgumentError "block not given" unless block_given?
        cid @ts.read tuple do |tuple, info|
          block.call tuple.data, TupleSpace.new(info)
        end
        @callback_ids << cid
      end

      def take(tuple)
        raise ArgumentError "block not given" unless block_given?
        cid = @ts.take tuple do |tuple, info|
          block.call tuple.data, TupleSpace.new(info)
        end
        @callback_ids << cid
      end

      def watch(tuple, &block)
        raise ArgumentError "block not given" unless block_given?
        cid = @ts.watch tuple do |tuple, info|
          block.call tuple.data, TupleSpace.new(info)
        end
        @callback_ids << cid
      end

      def close
        @callback_ids.each do |id|
          @ts.cancel id
        end
      end
    end

  end
end

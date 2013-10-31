module LindaBase
  class CodeRunner

    attr_reader :workers, :path

    def initialize(path=File.expand_path("../workers", File.dirname(__FILE__)))
      @path = path
      ::FileUitls.mkdir_p @path unless File.exists? @path
      @workers = Dir.glob(File.join @path, "*.rb").map{|i|
        Hashie::Mash.new(:code => File.open(i).read,
                         :path => i,
                         :name => File.basename(i))
      }
    end

    def run(space_name)
      ts = TupleSpace.new space_name
      @workers.each do |w|
        ts.instance_eval w.code
      end
    end

    class TupleInfo < Hashie::Mash
    end

    class TupleSpace
      def initialize(space_name)
        @ts = Sinatra::RocketIO::Linda.tuplespaces[space_name]
      end

      def write(tuple)
        @ts.write tuple
      end

      def read(tuple)
        raise ArgumentError "block not given" unless block_given?
        @ts.read tuple do |tuple, info|
          block.call tuple.data, TupleSpace.new(info)
        end
      end

      def take(tuple)
        raise ArgumentError "block not given" unless block_given?
        @ts.take tuple do |tuple, info|
          block.call tuple.data, TupleSpace.new(info)
        end
      end

      def watch(tuple, &block)
        raise ArgumentError "block not given" unless block_given?
        @ts.watch tuple do |tuple, info|
          block.call tuple.data, TupleSpace.new(info)
        end
      end
    end

  end
end

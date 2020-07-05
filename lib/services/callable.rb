module Services
  module Callable
    module ClassMethods
      def call(*args)
        new(*args).result
      end

      def receive(*arguments)
        define_method(:initialize) do |*parameters|
          unless arguments.size == parameters.size
            raise ArgumentError, 'wrong number of arguments' \
              " given #{parameters.size}, expected #{arguments.size}"
          end

          arguments.zip(parameters).each do |argument, parameter|
            if argument.to_s == 'params'
              instance_variable_set("@params", parameter || {})
            else
              instance_variable_set("@#{argument}", parameter)
            end
          end
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def result
      raise NotImplementedError
    end
  end
end

module PayStand
  module Testing
    module Config
      @test_mode = :disable
      def enable(&block)
        test_mode(:enable, &block)
      end

      def disable(&block)
        Testing.reset
        Data.instance.reset
        test_mode(:disable, &block)
      end

      def enabled?
        @test_mode == :enable
      end

      def disabled?
        @test_mode == :disable
      end

      private

      def test_mode(mode)
        if block_given?
          current_mode = @test_mode
          begin
            @test_mode = mode
            yield
          ensure
            @test_mode = current_mode
          end
        else
          @test_mode = mode
        end
      end
    end
  end
end

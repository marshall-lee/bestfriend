require 'set'

module BestFriend::FFmpeg
  module DSL
    module Global
      class CpuFlags
        NAMES = %w[
          mmxext
          sse
          sse2
          sse2slow
          sse3
          sse3slow
          ssse3
          atom
          sse4_1
          sse4_2
          avx
          xop
          fma4
          3dnow
          3dnowext
          cmov

          armv5te
          armv6
          armv6t2
          vfp
          vfpv3
          neon

          altivec

          pentium2
          pentium3
          pentium4
          k6
          k62
          athlon
          athlonxp
          k8
        ].map(&:freeze)
        PLUS = "+".freeze
        MINUS = "-".freeze

        def initialize
          @cpu_flags = []
          @enabled_cpu_flags = Set.new
          @disabled_cpu_flags = Set.new
        end

        def clear
          @cpu_flags.clear
          @enabled_cpu_flags.clear
          @disabled_cpu_flags.clear
        end

        NAMES.each do |flag_name|
          flag = flag_name.gsub("_", ".")
          plus_flag = "#{PLUS}#{flag}".freeze
          minus_flag = "#{MINUS}#{flag}".freeze

          define_method "enable_#{flag_name}" do
            @cpu_flags << plus_flag
            @enabled_cpu_flags << plus_flag
            @disabled_cpu_flags.delete minus_flag
          end

          define_method "disable_#{flag_name}" do
            @cpu_flags << minus_flag
            @disabled_cpu_flags << minus_flag
            @enabled_cpu_flags.delete plus_flag
          end
        end

        def build
          @cpu_flags.select { |flag|
            if flag.start_with? PLUS
              @enabled_cpu_flags.include? flag
            else
              @disabled_cpu_flags.include? flag
            end
          }.join
        end
      end
    end
  end
end

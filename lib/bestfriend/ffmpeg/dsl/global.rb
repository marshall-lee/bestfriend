require 'bestfriend/ffmpeg/dsl/global/cpu_flags'

module BestFriend::FFmpeg
  module DSL
    module Global
      def build
        result = ""
        result << "-cpuflags #{@cpu_flags.build}"   if @cpu_flags
        result << (@overwrite ? "-y" : "-n")        unless @overwrite.nil?
        result << (@stats ? "-stats" : "-nostats")  unless @stats.nil?
        result << "-progress #{@progress_url}"      if @progress_url
        result << "-debug_ts"                       if @debug_ts
        result << "-qphist"                         if @qphist
        result << "-benchmark"                      if @benchmark
        result << "-benchmark_all"                  if @benchmark_all
        result << "-dump"                           if @dump
        result << "-hex"                            if @hex
        result << "-override_ffserver"              if @override_ffserver
        result << "-filter_complex #{@filtergraph}" if @filtergraph
        return result
      end

      # Define a complex filtergraph
      def filter_complex
        @filtergraph ||= FilterGraph
      end
      alias_method :lavfi, :filter_complex

      def cpuflags
        @cpu_flags ||= CpuFlags.new
        @cpu_flags.instance_eval(proc)
      end
      alias_method :cpu_flags, :cpuflags

      def cpuflags!
        @cpu_flags = CpuFlags.new
        @cpu_flags.instance_eval(proc)
      end
      alias_method :cpu_flags!, :cpuflags!

      # Overwrite output files without asking.
      def overwrite!
        @overwrite = true
      end

      # Do not overwrite output files, and exit immediately if a specified output file already exists.
      def do_not_overwrite!
        @overwrite = false
      end

      # Print encoding progress/statistics.
      def stats!
        @stats = true
      end

      # Don't print encoding progress/statistics.
      def nostats!
        @stats = false
      end
      alias_method :no_stats!, :nostats!

      # Send program-friendly progress information to url.
      def progress(url)
        @progress_url = url
      end

      # Print timestamp information.
      def debug_ts!
        @debug_ts = true
      end
      alias_method :enable_debug_ts, :debug_ts!

      # Show QP histogram
      def qphist!
        @qphist = true
      end
      alias_method :enable_qphist, :qphist!

      # Show benchmarking information at the end of an encode.
      def benchmark!
        @benchmark = true
      end
      alias_method :enable_benchmark, :benchmark!

      # Show benchmarking information during the encode.
      def benchmark_all!
        @benchmark_all = true
      end
      alias_method :enable_benchmark_all, :benchmark_all!

      # Dump each input packet to stderr.
      def dump!
        @dump = true
      end
      alias_method :enable_dump, :dump!

      # When dumping packets, also dump the payload.
      def hex!
        @hex = true
      end
      alias_method :enable_hex, :hex!

      # Overrides the input specifications from ffserver.
      def override_ffserver
        @override_ffserver = true
      end
    end
  end
end

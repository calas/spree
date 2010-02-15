module Bundler
  class Spree
    class << self
      def extensions_gemfiles
        Dir.glob(Bundler.root.join("vendor/extensions/**/Gemfile"))
      end

      def development_gemfile
        Bundler.root.join("Gemfile.development")
      end

      def gemfiles
        extensions_gemfiles << development_gemfile
      end

      def gemfile_fingerprint
        gemfile = File.read(Bundler.root.join("Gemfile")).tap do |gemfile|
          gemfiles.each do |gem_file|
            warn gem_file
            gemfile << File.read(gem_file)
          end
        end
        Digest::SHA1.hexdigest(gemfile)
      end
    end
  end

  class Dsl
    def load_extensions_gemfiles
      Bundler::Spree.extensions_gemfiles.each do |ext_gemfile|
        instance_eval(File.read(ext_gemfile), ext_gemfile)
      end
    end

    def load_development_gemfile
      development_gemfile = Bundler::Spree.development_gemfile
      if File.exists?(development_gemfile)
        instance_eval(File.read(development_gemfile), development_gemfile)
      end
    end
  end

  class Runtime
    def gemfile_fingerprint
      Bundler::Spree.gemfile_fingerprint
    end
  end

  # TODO: Figure out to hack this step since 'bundle install' command
  # doesn't evaluate Gemfile before obtaining the fingerprint. This is
  # causing that 'bundle install' should always be called with the
  # '--relock' option.
  class Definition
    def self.from_lock(lockfile)
      locked_definition = Locked.new(YAML.load_file(lockfile))
      unless locked_definition.hash == Bundler::Spree.gemfile_fingerprint
        raise GemfileError, "You changed your Gemfile after locking. Please relock using `bundle lock`."
      end
      locked_definition
    end
  end
end

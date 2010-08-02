# The program is a simple, unofficial, ruby client API
# for using Google Translate.
#
# Author::    Dingding Ye  (mailto:yedingding@gmail.com)
# Copyright:: Copyright (c) 2007 Dingding Ye
# License::   Distributes under MIT License

module Translate
  class UnsupportedLanguagePair < StandardError
  end

  class RTranslator
    require 'net/http'
    
    # Google AJAX Language REST Service URL
    GOOGLE_TRANSLATE_URL = "http://ajax.googleapis.com/ajax/services/language/translate"

    # Default version of Google AJAX Language API
    DEFAULT_VERSION = "1.0"

    attr_accessor :version, :key
    attr_reader :default_from, :default_to

    class << self
      def translate(text, from, to, options = {})
        if options[:method] == :post
          RTranslator.new.post_translate(text, { :from => from, :to => to })
        else
          RTranslator.new.translate(text, { :from => from, :to => to })
        end
      end
      alias_method :t, :translate

      def translate_strings(text_array, from, to, options = {})
        method = options[:method] || :get
        RTranslator.new.translate_strings(text_array, {:from => from, :to => to, :method => method})
      end

      def translate_string_to_languages(text, options)
        RTranslator.new.translate_string_to_languages(text, options)
      end

      def batch_translate(translate_options, options = {})
        RTranslator.new.batch_translate(translate_options, options)
      end
    end

    def initialize(version = DEFAULT_VERSION, key = nil, default_from = nil, default_to = nil)
      @version = version
      @key = key
      @default_from = default_from
      @default_to = default_to

      if @default_from && !(RTranslate::Google::Lanauage.supported?(@default_from))
        raise StandardError, "Unsupported source language '#{@default_from}'"
      end

      if @default_to && !(RTranslate::Google::Lanauage.supported?(@default_to))
        raise StandardError, "Unsupported destination language '#{@default_to}'"
      end
    end

    # translate the string from a source language to a target language.
    #
    # Configuration options:
    # * <tt>:from</tt> - The source language
    # * <tt>:to</tt> - The target language
    def translate(text, options = { })
      from = options[:from] || @default_from
      to = options[:to] || @default_to
      if (from.nil? || RTranslate::Google::Language.supported?(from)) && RTranslate::Google::Language.supported?(to)
        from = from ? RTranslate::Google::Language.abbrev(from) : nil
        to = RTranslate::Google::Language.abbrev(to)
        langpair = "#{from}|#{to}"

        text.mb_chars.scan(/(.{1,500})/).inject("") do |result, st|
          url = "#{GOOGLE_TRANSLATE_URL}?q=#{st}&langpair=#{langpair}&v=#{@version}"
          if @key
            url << "&key=#{@key}"
          end
          result += do_translate(url)
        end
      else
        raise UnsupportedLanguagePair, "Translation from '#{from}' to '#{to}' isn't supported yet!"
      end
    end
    
    # This one for a POST request
    def post_translate(text, options = { })
      from = options[:from] || @default_from
      to = options[:to] || @default_to
      if (from.nil? || RTranslate::Google::Language.supported?(from)) && RTranslate::Google::Language.supported?(to)
        from = from ? RTranslate::Google::Language.abbrev(from) : nil
        to = RTranslate::Google::Language.abbrev(to)
        post_options = {:langpair => "#{from}|#{to}", :v => @version}
        post_options[:key] = @key if @key
        
        text.mb_chars.scan(/(.{1,500})/).inject("") do |result, st|
          url = GOOGLE_TRANSLATE_URL
          post_options[:q] = st
          result += do_post_translate(url,post_options)
        end
      else
        raise UnsupportedLanguagePair, "Translation from '#{from}' to '#{to}' isn't supported yet!"
      end
    end

    # translate several strings, all from the same source language to the same target language.
    #
    # Configuration options
    # * <tt>:from</tt> - The source language
    # * <tt>:to</tt> - The target language
    def translate_strings(text_array, options = { })
      text_array.collect do |text|
        if options[:method] == :post
          self.post_translate(text, options)
        else
          self.translate(text, options)
        end
      end
    end

    # Translate one string into several languages.
    #
    # Configuration options
    # * <tt>:from</tt> - The source language
    # * <tt>:to</tt> - The target language list
    # Example:
    #
    # translate_string_to_languages("China", {:from => "en", :to => ["zh-CN", "zh-TW"]})
    def translate_string_to_languages(text, options)
      options[:to].collect do |to|
        if options[:method] == :post
          self.post_translate(text, { :from => options[:from], :to => to })
        else
          self.translate(text, { :from => options[:from], :to => to })
        end
      end
    end

    # Translate several strings, each into a different language.
    #
    # Examples:
    #
    # batch_translate([["China", {:from => "en", :to => "zh-CN"}], ["Chinese", {:from => "en", :to => "zh-CN"}]])
    def batch_translate(translate_options, options = {})
      translate_options.collect do |text, option|
        if options[:method] == :post
          self.post_translate(text, option)
        else
          self.translate(text, option)
        end
      end
    end

    private
    
    def do_translate(url) #:nodoc:
      jsondoc = open(URI.escape(url)).read
      response = JSON.parse(jsondoc)
      if response["responseStatus"] == 200
        response["responseData"]["translatedText"]
      else
        raise StandardError, response["responseDetails"]
      end
    rescue Exception => e
      raise StandardError, e.message
    end
    
    def do_post_translate(url, options = {}) #:nodoc:
      jsondoc = Net::HTTP.post_form(URI.parse(url),options).body
      response = JSON.parse(jsondoc)
      
      if response["responseStatus"] == 200
        response["responseData"]["translatedText"]
      else
        raise StandardError, response["responseDetails"]
      end
    rescue Exception => e
      raise StandardError, e.message
    end
    
  end
end

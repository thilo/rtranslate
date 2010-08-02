module RTranslate
  module Google
    module Language
      Languages = {
      "lo"=>"LAOTHIAN", 
      "ta"=>"TAMIL", 
      "eu"=>"BASQUE", 
      "iw"=>"HEBREW", 
      "my"=>"BURMESE", 
      "uk"=>"UKRAINIAN", 
      "sk"=>"SLOVAK", 
      "ky"=>"KYRGYZ", 
      "zh-TW"=>"CHINESE_TRADITIONAL", 
      "pa"=>"PUNJABI", 
      "sl"=>"SLOVENIAN", 
      "ps"=>"PASHTO", 
      "ru"=>"RUSSIAN", 
      "mk"=>"MACEDONIAN", 
      "zh"=>"CHINESE", 
      "te"=>"TELUGU", 
      "bn"=>"BENGALI", 
      "cy"=>"WELSH", 
      "hr"=>"CROATIAN", 
      "ml"=>"MALAYALAM", 
   "lt"=>"LITHUANIAN", 
   "bo"=>"TIBETAN", 
   "ja"=>"JAPANESE", 
   "tg"=>"TAJIK", 
   "af"=>"AFRIKAANS", 
   "fr"=>"FRENCH", 
   "kk"=>"KAZAKH", 
   "th"=>"THAI", 
   "sq"=>"ALBANIAN", 
   "fa"=>"PERSIAN", 
   "lv"=>"LATVIAN", 
   "vi"=>"VIETNAMESE", 
   "ur"=>"URDU", 
   "az"=>"AZERBAIJANI", 
   "ne"=>"NEPALI", 
   "km"=>"KHMER", 
   "da"=>"DANISH", 
   "sr"=>"SERBIAN", 
   "hu"=>"HUNGARIAN", 
   "mn"=>"MONGOLIAN", 
   "gl"=>"GALICIAN", 
   "kn"=>"KANNADA", 
   "el"=>"GREEK", 
   "ko"=>"KOREAN", 
   "sa"=>"SANSKRIT", 
   "zh-CN"=>"CHINESE_SIMPLIFIED", 
   "gn"=>"GUARANI", 
   "dv"=>"DHIVEHI", 
   "or"=>"ORIYA", 
   "tl"=>"TAGALOG", 
   "chr"=>"CHEROKEE", 
   "en"=>"ENGLISH", 
   "hy"=>"ARMENIAN", 
   "mr"=>"MARATHI", 
   "sv"=>"SWEDISH", 
   "ms"=>"MALAY", 
   "am"=>"AMHARIC", 
   "eo"=>"ESPERANTO", 
   "sd"=>"SINDHI", 
   "pl"=>"POLISH", 
   "de"=>"GERMAN", 
   "be"=>"BELARUSIAN", 
   "nl"=>"DUTCH", 
   "mt"=>"MALTESE", 
   "sw"=>"SWAHILI", 
   "ka"=>"GEORGIAN", 
   "is"=>"ICELANDIC", 
   "ro"=>"ROMANIAN", 
   "ug"=>"UIGHUR", 
   "yi"=>"YIDDISH", 
   "hi"=>"HINDI", 
   "fi"=>"FINNISH", 
   "ku"=>"KURDISH", 
   "pt-PT"=>"PORTUGUESE", 
   "bg"=>"BULGARIAN", 
   "uz"=>"UZBEK", 
   "ga"=>"IRISH", 
   "it"=>"ITALIAN", 
   "tr"=>"TURKISH", 
   "bh"=>"BIHARI", 
   "es"=>"SPANISH", 
   "iu"=>"INUKTITUT", 
   "si"=>"SINHALESE", 
   "no"=>"NORWEGIAN", 
   "ca"=>"CATALAN", 
   "id"=>"INDONESIAN", 
      "ar"=>"ARABIC", 
      "cs"=>"CZECH", 
      "et"=>"ESTONIAN", 
      "gu"=>"GUJARATI"}
      
      # judge whether the language is supported by google translate
      def supported?(language)
        if Languages.key?(language) || Languages.value?(language.upcase)
          true
        else
          false
        end
      end
      module_function :supported?

      # get the abbrev of the language
      def abbrev(language)
        if supported?(language)
          if Languages.key?(language)
            language
          else
            language.upcase!
            Languages.each do |k,v|
              if v == language
                return k
              end
            end
          end
        else
          nil
        end
      end
      module_function :abbrev
    end
  end
end
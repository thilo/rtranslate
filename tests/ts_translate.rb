# -*- coding: utf-8 -*-
$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'test/unit'
require 'rtranslate'

class Translate::TranslateTest < Test::Unit::TestCase
  include RTranslate::Google::Language
  
  def test_english_translate
    assert_equal("مرحبا العالم", Translate.t("Hello world", "ENGLISH", "ARABIC"));
    assert_equal("您好世界", Translate.t("Hello world", "ENGLISH", "CHINESE_SIMPLIFIED"));
    assert_equal("Bonjour tout le monde", Translate.t("Hello world", "ENGLISH", "FRENCH"));
    assert_equal("Hallo Welt", Translate.t("Hello world", "ENGLISH", "GERMAN"));
    assert_equal("Ciao a tutti", Translate.t("Hello world", "ENGLISH", "ITALIAN"));
    assert_equal("こんにちは、世界", Translate.t("Hello world", "ENGLISH", "JAPANESE"));
    assert_equal("안녕하세요 세상", Translate.t("Hello world", "ENGLISH", "KOREAN"));
    assert_equal("Olá mundo", Translate.t("Hello world", "ENGLISH", "PORTUGUESE"));
    assert_equal("Привет мир", Translate.t("Hello world", "ENGLISH", "RUSSIAN"));
    assert_equal("¡Hola, mundo", Translate.t("Hello world", "ENGLISH", "SPANISH"));
  end

  def test_auto_detect_translate
    assert_equal("مرحبا العالم", Translate.t("Hello world", nil, "ARABIC"));
    assert_equal("您好世界", Translate.t("Hello world", nil, "CHINESE_SIMPLIFIED"));
    assert_equal("Bonjour tout le monde", Translate.t("Hello world", nil, "FRENCH"));
    assert_equal("Hallo Welt", Translate.t("Hello world", nil, "GERMAN"));
    assert_equal("Ciao a tutti", Translate.t("Hello world", nil, "ITALIAN"));
    assert_equal("こんにちは、世界", Translate.t("Hello world", nil, "JAPANESE"));
    assert_equal("안녕하세요 세상", Translate.t("Hello world", nil, "KOREAN"));
    assert_equal("Olá mundo", Translate.t("Hello world", nil, "PORTUGUESE"));
    assert_equal("Привет мир", Translate.t("Hello world", nil, "RUSSIAN"));
    assert_equal("¡Hola, mundo", Translate.t("Hello world", nil, "SPANISH"));
  end

  def test_chinese_translate
    assert_equal("Hello World", Translate.t("您好世界", "CHINESE", "ENGLISH"))
    assert_equal("Hello World", Translate.t("您好世界", 'zh', 'en'))
  end

  def test_unsupported_translate
    assert_raise UnsupportedLanguagePair do
      Translate::RTranslator.t("您好世界", 'zh', 'hz')
    end
  end

  def test_translate_strings
    assert_equal(["你好", "世界"], Translate::RTranslator.translate_strings(["Hello", "World"],  "en", "zh-CN"))
  end

  def test_translate_string_to_languages
    assert_equal(["您好世界", "ハローワールド"], Translate::RTranslator.translate_string_to_languages("Hello World", {:from => "en", :to => ["zh-CN", "ja"]}))
  end

  def test_batch_translate
    assert_equal(["您好世界", "ハローワールド"],
        Translate::RTranslator.batch_translate([["Hello World", {:from => "en", :to => "zh-CN"}], ["Hello World", {:from => "en", :to => "ja"}]]))
  end
  
  def test_post_translate
    # Basic
    assert_equal("مرحبا العالم", Translate.t("Hello world", "ENGLISH", "ARABIC", {:method => :post}));
    # Auto Detect Language
    assert_equal("您好世界", Translate.t("Hello world", nil, "CHINESE_SIMPLIFIED", {:method => :post}));
    #Chinese
    assert_equal("Hello World", Translate.t("您好世界", "CHINESE", "ENGLISH", {:method => :post}))
    #Strings
    assert_equal(["你好", "世界"], Translate::RTranslator.translate_strings(["Hello", "World"],  "en", "zh-CN", {:method => :post}))
    # String to Languages
    assert_equal(["您好世界", "ハローワールド"], Translate::RTranslator.translate_string_to_languages("Hello World", {:from => "en", :to => ["zh-CN", "ja"], :method => :post}))
    # Batch
    assert_equal(["您好世界", "ハローワールド"],        
      Translate::RTranslator.batch_translate([["Hello World", {:from => "en", :to => "zh-CN"}], ["Hello World", {:from => "en", :to => "ja"}]], {:method => :post}))
  end
end

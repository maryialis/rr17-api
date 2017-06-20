require 'logger'

module Parser
  # Base parser class.
  # parse_usd, parse_eur, parse_rur should be implemented in its descendants
  class BaseParser
    def initialize
      @logger = Logger.new("#{Rails.root}/log/parser.log")
    end
  
    def parse(input)
      usd = parse_usd(input)
      eur = parse_eur(input)
      rur = parse_rur(input)
      { parsed: true, result: { usd: usd, eur: eur, rur: rur } }
    rescue StandardError => e
      @logger.error(e.message)
      { parsed: false, error: e.message }
    end

    protected

    def parse_usd(_input)
      raise NotImplementedError
    end

    def parse_eur(_input)
      raise NotImplementedError
    end

    def parse_rur(_input)
      raise NotImplementedError
    end

    def parse_impl(input)
      yield input
    end
  end

  # Parser to extract rates from https://belarusbank.by
  class BelarusParser < BaseParser
    def parse_usd(input)
      parse_impl(input) do
        m = input.match(%r{\(1 USD\)\s*</td>\s*<td[^>]+>\s*(\d+.\d{4})\s*</td>})
        raise 'Failed to extract Belarusbank\'s USD rate' unless m
        m[1]
      end
    end

    def parse_eur(input)
      parse_impl(input) do
        m = input.match(%r{\(1 EUR\)\s*</td>\s*<td[^>]+>\s*(\d+.\d{4})\s*</td>})
        raise 'Failed to extract Belarusbank\'s EUR rate' unless m
        m[1]
      end
    end

    def parse_rur(input)
      parse_impl(input) do
        m = input.match(%r{\(100 RUB\)\s*</td>\s*<td[^>]+>\s*(\d+.\d{4})\s*</td>})
        raise 'Failed to extract Belarusbank\'s RUR rate' unless m
        (m[1].to_f / 100).round(4)
      end
    end
  end

  # b = BelarusParser.new
  # puts b.parse(File.open("#{Rails.root}/test/belarusbank.html",
  #                          encoding: 'windows-1251:utf-8').read)

  # Parser to extract rates from https://tb.by/
  class TechnoParser < BaseParser
    def parse_usd(input)
      parse_impl(input) do
        m = input.match(%r{<strong>USD</strong></span>\s*</div>\s*</td>
\s*<td\s+class="units_column">1</td>\s*<td>\s*<span[^>]+>(\d+.\d{2})</span>}x)
        raise 'Failed to extract Technobank\'s USD rate' unless m
        m[1]
      end
    end

    def parse_eur(input)
      parse_impl(input) do
        m = input.match(%r{<strong>EUR</strong></span>\s*</div>\s*</td>
\s*<td\s+class="units_column">1</td>\s*<td>\s*<span[^>]+>(\d+.\d{2})</span>}x)
        raise 'Failed to extract Technobank\'s EUR rate' unless m
        m[1]
      end
    end

    def parse_rur(input)
      parse_impl(input) do
        m = input.match(%r{<strong>RUB</strong></span>\s*</div>\s*</td>
\s*<td\s+class="units_column">100</td>\s*<td>\s*<span[^>]+>(\d+.\d{2})</span>}x)
        raise 'Failed to extract Technobank\'s RUR rate' unless m
        (m[1].to_f / 100).round(4)
      end
    end
  end

  # t = TechnoParser.new
  # puts t.parse(File.open("#{Rails.root}/test/technobank.html").read)
  # puts t.parse('rjgijriojgsre;jio')
end

require 'logger'

module Parser
  class BaseParser
    def parse(input)
      usd = parse_usd(input)
      eur = parse_eur(input)
      rur = parse_rur(input)
      {parsed: true, result: {usd: usd, eur: eur, rur: rur}}
      rescue StandardError => e
        @@logger.error(e.message)
        {parsed: false, error: e.message}
    end
    
    protected
    def parse_usd(input)
      raise NotImplementedError
    end
    def parse_eur(input)
      raise NotImplementedError
    end
    def parse_rur(input)
      raise NotImplementedError
    end
    def parse_impl(input)
      yield input
    end
    @@logger = Logger.new('../../log/parser.log')
  end
  
  class BelarusParser < BaseParser
    def parse_usd(input)
      parse_impl(input) {input.match(/\(1 USD\)\s*<\/td>\s*<td[^>]+>\s*(\d+.\d{4})\s*<\/td>/)[1]}
    end
    def parse_eur(input)
      parse_impl(input) {input.match(/\(1 EUR\)\s*<\/td>\s*<td[^>]+>\s*(\d+.\d{4})\s*<\/td>/)[1]}
    end
    def parse_rur(input)
      parse_impl(input) {input.match(/\(100 RUB\)\s*<\/td>\s*<td[^>]+>\s*(\d+.\d{4})\s*<\/td>/)[1].to_f / 100}
    end
    def parse_usd(input)
      parse_impl(input) do
        m = input.match(/\(1 USD\)\s*<\/td>\s*<td[^>]+>\s*(\d+.\d{4})\s*<\/td>/)
        raise 'Failed to extract Belarusbank\'s USD rate' if !m
        m[1]
       end
    end
    def parse_eur(input)
      parse_impl(input) do
        m = input.match(/\(1 EUR\)\s*<\/td>\s*<td[^>]+>\s*(\d+.\d{4})\s*<\/td>/)
        raise 'Failed to extract Belarusbank\'s EUR rate' if !m
        m[1]
       end
    end
    def parse_rur(input)
      parse_impl(input) do
        m = input.match(/\(100 RUB\)\s*<\/td>\s*<td[^>]+>\s*(\d+.\d{4})\s*<\/td>/)
        raise 'Failed to extract Belarusbank\'s RUR rate' if !m
        (m[1].to_f / 100).round(4)
      end
    end
  end
  
  #b = BelarusParser.new
  #puts b.parse(File.open('../../test/belarusbank.html', encoding: 'windows-1251:utf-8').read)
  
  class TechnoParser < BaseParser
    def parse_usd(input)
      parse_impl(input) do
        m = input.match(/<strong>USD<\/strong><\/span>\s*<\/div>\s*<\/td>\s*<td class="units_column">1<\/td>\s*<td>\s*<span[^>]+>(\d+.\d{2})<\/span>/)
        raise 'Failed to extract Technobank\'s USD rate' if !m
        m[1]
       end
    end
    def parse_eur(input)
      parse_impl(input) do
        m = input.match(/<strong>EUR<\/strong><\/span>\s*<\/div>\s*<\/td>\s*<td class="units_column">1<\/td>\s*<td>\s*<span[^>]+>(\d+.\d{2})<\/span>/)
        raise 'Failed to extract Technobank\'s EUR rate' if !m
        m[1]
       end
    end
    def parse_rur(input)
      parse_impl(input) do
        m = input.match(/<strong>RUB<\/strong><\/span>\s*<\/div>\s*<\/td>\s*<td class="units_column">100<\/td>\s*<td>\s*<span[^>]+>(\d+.\d{2})<\/span>/)
        raise 'Failed to extract Technobank\'s RUR rate' if !m
        (m[1].to_f / 100).round(4)
      end
    end
  end
  
  #t = TechnoParser.new
  #puts t.parse(File.open('../../test/technobank.html').read)
  #puts t.parse('rjgijriojgsre;jio')
end

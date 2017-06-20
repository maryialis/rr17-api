require 'rails_helper'
require_relative '../lib/rr17-api/parser'

shared_examples "an appropriate parser" do |input|
  subject { described_class.new }

  before do
    @result = subject.parse(input)
  end

  it "has 'parsed' field in the result" do
    expect(@result).to have_key(:parsed)
  end

  it "sets 'parsed' to true" do
    expect(@result[:parsed]).to eql(true)
  end
   
  it "has 'result' field in the result" do
    expect(@result).to have_key(:result)
  end
    
  it "returns result" do
    expect(@result[:result]).to be_truthy
  end
     
  it "includes usd rate into result" do
    expect(@result[:result][:usd]).to be_truthy
  end
   
  it "includes eur rate into result" do
    expect(@result[:result][:eur]).to be_truthy
  end
     
  it "includes rur rate into result" do
    expect(@result[:result][:rur]).to be_truthy
  end
end

shared_examples "a nonappropriate parser" do |input|
  subject { described_class.new }

  before do
    @result = subject.parse(input)
  end

  it "sets 'parsed' to false" do
    expect(@result[:parsed]).to eql(false)
  end
     
  it "returns error" do
    expect(@result[:error]).to be_truthy
  end
end

describe Parser::TechnoParser do
  describe "#parse" do
    context "given valid input" do
      include_examples "an appropriate parser", File.open("#{Rails.root}/test/technobank.html").read
    end

    context "given invalid input" do
      include_examples "a nonappropriate parser", 'rjgijriojgsre;jio'
    end
  end
end

describe Parser::BelarusParser do
  describe "#parse" do
    context "given valid input" do
      include_examples "an appropriate parser", File.open("#{Rails.root}/test/belarusbank.html", encoding: 'windows-1251:utf-8').read
    end

    context "given invalid input" do
      include_examples "a nonappropriate parser", 'rjgijriojgsre;jio'
    end
  end
end

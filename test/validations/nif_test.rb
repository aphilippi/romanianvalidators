# -*- encoding: utf-8 -*-
require 'test_helper.rb'
valid_nifs = File.read('test/data/valid_nifs.txt').split

describe "Numar de Identificare Fiscala" do

  describe "for valid NIFs" do
    valid_nifs.each do |nif|
      it "accepts valid NIF" do
        subject = build_nif_record({:nif => nif})
        subject.valid?.must_equal true
        subject.errors.size.must_equal 0
      end
    end
  end

  describe "for invalid NIFs" do
    it "rejects invalid NIFs and generates an error message" do
      subject = build_nif_record :nif => '1'
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
    end
    it "rejects invalid nifs and allows custom error message" do
      message = "Some custom error message"
      subject = build_nif_record({:nif => '1'}, {:message => message})
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
      subject.errors[:nif].must_equal Array.wrap(message)
    end
  end

  def build_nif_record(attrs = {}, opts = {})
    custom_message = opts.fetch(:message, false)
    TestRecord.reset_callbacks(:validate)
    if custom_message
      TestRecord.validates :nif, :nif => {:message => custom_message}
    else
      TestRecord.validates :nif, :nif => true
    end
    TestRecord.new attrs
  end

end

require 'spec_helper'

describe AUOM,'.try_convert' do
  subject { object.try_convert(value) }

  let(:object) { AUOM::Unit }

  context 'with nil' do
    let(:value) { nil }

    it { should be(nil) }
  end

  context 'with fixnum' do
    let(:value) { 1 } 

    it { should eql(AUOM::Unit.new(1)) }
  end

  context 'with rational' do
    let(:value) { Rational(2,1) } 

    it { should eql(AUOM::Unit.new(2)) }
  end

  context 'with Object' do
    let(:value) { Object.new } 

    it { should be(nil) }
  end
end
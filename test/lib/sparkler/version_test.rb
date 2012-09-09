require_relative '../../test_helper'

describe Sparkler do
  it "is versioned" do
    Sparkler::VERSION.wont_be_nil
  end
end

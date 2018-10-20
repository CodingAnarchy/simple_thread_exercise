require 'byebug'
require_relative '../project_set'

describe ProjectSet do
  context "set #1" do
    let(:first_set) { ProjectSet.new([Project.new("2015-9-1", "2015-9-3", "low")]) }

    it "has the duration between 9/1 and 9/3" do
      expect(first_set.duration).to eq((Date.parse("2015-9-1")..Date.parse("2015-9-3")))
    end

    it "has the correct sum for the first project set" do
      expect(first_set.reimbursement).to eq(165)
    end
  end
end

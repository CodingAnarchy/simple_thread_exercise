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

  context "set #2" do
    let(:first_project) { Project.new("2015-9-1", "2015-9-1", "low") }
    let(:second_project) { Project.new("2015-9-2", "2015-9-6", "high") }
    let(:third_project) { Project.new("2015-9-6", "2015-9-8", "low") }
    let(:second_set) { ProjectSet.new([first_project, second_project, third_project]) }

    it "has the duration between 9/1 and 9/8" do
      expect(second_set.duration).to eq((Date.parse("2015-9-1")..Date.parse("2015-9-8")))
    end

    it "has the correct sum for the second project set" do
      # Sum is (2 * 45) for low-cost travel days on both ends of set + (5 * 85) for the high cost project and 75 for the low cost project non-overlapping day = 590
      expect(second_set.reimbursement).to eq(590)
    end
  end

  context "set #3" do
    let(:first_project) { Project.new("2015-9-1", "2015-9-3", "low") }
    let(:second_project) { Project.new("2015-9-5", "2015-9-7", "high") }
    let(:third_project) { Project.new("2015-9-8", "2015-9-8", "high") }
    let(:third_set) { ProjectSet.new([first_project, second_project, third_project]) }

    it "has the duration between 9/1 and 9/8" do
      expect(third_set.duration).to eq((Date.parse("2015-9-1")..Date.parse("2015-9-8")))
    end

    it "has the correct sum for the third project set" do
      # Sum is 45 (low-cost travel) + 75 (low cost full) + 45 (low cost travel) + 0 (none) + 55 (high cost travel) + 2 * 85 (high cost full) + 55 (high cost travel) = 445
      expect(third_set.reimbursement).to eq(445)
    end
  end
end

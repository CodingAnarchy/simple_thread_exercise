require_relative '../project_set'

describe ProjectSet do
  context "set #1" do
    let(:first_set) { ProjectSet.new([Project.new("9/1/2015", "9/3/2015", "low")]) }

    it "has the duration between 9/1 and 9/3" do
      expect(first_set.duration).to eq((Date.parse("9/1/2015")..Date.parse("9/3/2015")))
    end
  end
end

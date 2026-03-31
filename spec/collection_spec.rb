require "spec_helper"

describe Her::Collection do
  let(:items) { [1, 2, 3, 4] }
  let(:metadata) { { name: "Testname" } }
  let(:errors) { { name: ["not_present"] } }

  describe "#new" do
    context "without parameters" do
      subject { Her::Collection.new }

      it { is_expected.to eq([]) }

      describe "#metadata" do
        subject { super().metadata }
        it { is_expected.to eq({}) }
      end

      describe "#errors" do
        subject { super().errors }
        it { is_expected.to eq({}) }
      end
    end

    context "with parameters" do
      subject { Her::Collection.new(items, metadata, errors) }

      it { is_expected.to eq([1, 2, 3, 4]) }

      describe "#metadata" do
        subject { super().metadata }
        it { is_expected.to eq(name: "Testname") }
      end

      describe "#errors" do
        subject { super().errors }
        it { is_expected.to eq(name: ["not_present"]) }
      end
    end
  end

  describe "Array methods preserve Collection type" do
    subject { Her::Collection.new(items, metadata, errors) }

    it "returns a Collection from #select" do
      result = subject.select(&:odd?)
      expect(result).to be_a(Her::Collection)
      expect(result).to eq([1, 3])
      expect(result.metadata).to eq(name: "Testname")
    end

    it "returns a Collection from #reject" do
      result = subject.reject(&:odd?)
      expect(result).to be_a(Her::Collection)
      expect(result).to eq([2, 4])
    end

    it "returns a Collection from #map" do
      result = subject.map { |x| x * 2 }
      expect(result).to be_a(Her::Collection)
      expect(result).to eq([2, 4, 6, 8])
    end

    it "returns a Collection from #first with count" do
      result = subject.first(2)
      expect(result).to be_a(Her::Collection)
      expect(result).to eq([1, 2])
    end
  end
end

require 'spec_helper'
require_relative '../models/search'

RSpec.describe Model::Search do
  #let(:users) JSON.parse(File.read("users.json"))
  subject {  Model::Search.new }

  describe "#search" do
    context "Search user by _id" do
      it "returns one" do
        expect(subject.search("users", "_id", 1)).to eq([hash[0]])
      end
    end

    # context "value is in key array" do
    #   it "returns two" do
    #     expect(subject.find("friends", "Harry")).to eq(hash[1,2])
    #   end
    # end
    #
    # context "only one hash has key" do
    #   it "returns one" do
    #     expect(subject.find("nargles_found", "3")).to eq([hash[2]])
    #   end
    # end
    #
    # context "key doesn't exist" do
    #   it "returns empty array" do
    #     expect(subject.find("deatheater", "Malfoy")).to be_empty
    #   end
    # end
    #
    # context "search is int" do
    #   it "returns one" do
    #     expect(subject.find("id", 2)).to eq([hash[1]])
    #   end
    # end
    #
    # context "search is int" do
    #   it "returns one" do
    #     expect(subject.find("id", 2)).to eq([hash[1]])
    #   end
    # end
    #
    # context "search is true" do
    #   it "returns one" do
    #     expect(subject.find("scarred", true)).to eq([hash[0]])
    #   end
    # end
    #
    # context "search is false" do
    #   it "returns two" do
    #     expect(subject.find("scarred", false)).to eq(hash[1,2])
    #   end
    # end
    #
    # context "search is false" do
    #   it "returns two" do
    #     expect(subject.find("nargles_found", nil)).to eq([hash[0]])
    #   end
    # end
  end
end

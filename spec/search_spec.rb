require 'spec_helper'
require_relative '../searchcli/search'

RSpec.describe SearchCli::Search do
  #let(:user) { SearchCli::User.first }
  #let(:organization) SearchCli::Organization.first
  #let(:ticket) SearchCli::Ticket.first
  subject {  SearchCli::Search.new }

  describe "#search" do

    context 'when organization exists' do
      it 'returns one' do
        expect(subject.search('organizations', '_id', 110)).not_to be_empty
      end
    end

    context 'when user exists' do
      it 'returns one' do
        expect(subject.search('users', '_id', 1)).not_to be_empty
      end
    end

    context 'when ticket exists' do
      it 'returns one' do
        expect(subject.search('tickets', 'subject', 'A Catastrophe in Laos')).not_to be_empty
      end
    end


    context 'when organization do not exist' do
      it 'returns empty' do
        expect(subject.search('organizations', '_id', 1000)).to be_empty
      end
    end

    context 'when user do not exist' do
      it 'returns empty' do
        expect(subject.search('users', '_id', 1000)).to be_empty
      end
    end

    context 'when ticket do not exist' do
      it 'returns empty' do
        expect(subject.search('tickets', '_id', 1000)).to be_empty
      end
    end

    context 'when search organization with invalid field' do
      it 'returns empty' do
        expect(subject.search('organizations', 'invalid', 110)).to be_empty
      end
    end

    context 'when search user with invalid field' do
      it 'returns empty' do
        expect(subject.search('users', 'invalid', 1)).to be_empty
      end
    end

    context 'when search ticket with invalid field' do
      it 'returns empty' do
        expect(subject.search('tickets', 'invalid', 'A Catastrophe in Laos')).to be_empty
      end
    end

    context 'organization name is present for a user' do
      it 'returns organization name' do
        expect(subject.search('users', '_id', 1)[0]).to include('organization_name')
      end
    end

    context 'tickets are present for a user' do
      it 'returns tickets' do
        expect(subject.search('users', '_id', 1)[0]).to include('tickets')
      end
    end

    context 'tickets are present for an organization' do
      it 'returns tickets' do
        expect(subject.search('organizations', '_id', 111)[0]).to include('tickets')
      end
    end

    context 'users are present for an organization' do
      it 'returns users' do
        expect(subject.search('organizations', '_id', 111)[0]).to include('users')
      end
    end

    context 'organization name is present for a ticket' do
      it 'returns organization name' do
        expect(subject.search('tickets', 'subject', 'A Catastrophe in Laos')[0]).to include('organization_name')
      end
    end

    context 'submitter is present for a ticket' do
      it 'returns submitter' do
        expect(subject.search('tickets', 'subject', 'A Catastrophe in Laos')[0]).to include('submitter')
      end
    end

    context 'assignee is present for a ticket' do
      it 'returns assignee' do
        expect(subject.search('tickets', 'subject', 'A Catastrophe in Laos')[0]).to include('assignee')
      end
    end

    context 'search for invalid resource' do
      it 'returns empty' do
        expect(subject.search('invalid', '_id', 1)).to be_empty
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

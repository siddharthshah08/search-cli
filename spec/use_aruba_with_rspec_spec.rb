require 'spec_helper'

  def load_cli
    a = `ruby cli.rb`
    puts a
    return a
  end
   # RSpec.describe 'First Run', :type => :aruba do
   #   let(:file) { 'file.txt' }
   #   let(:content) { 'Hello World' }
   #
   #   before(:each) { write_file file, content }
   #
   #   it { expect { load_cli }.to output(/Welcome to Zendesk Search/) }
   # end
    RSpec.describe 'Check if directory and file exist', :type => :aruba do
      let(:directory) { '../resources' }
      let(:file) { '../resources/tickets.json' }
      before(:each) { create_directory(directory) }
  before(:each) { touch(file) }

      it { expect(check_file_presence).to be true }
      it { expect(exist?(file)).to be true }
    end

   RSpec.describe "output.to_stdout matcher" do
     # specify { expect { load_cli }.to output(/Welcome to Zendesk Search/).to_stdout }
     # specify { expect { print('foo') }.to output('foo').to_stdout }
     # specify { expect { print('foo') }.to output(/foo/).to_stdout }
     # specify { expect { }.to_not output.to_stdout }
     # specify { expect { print('foo') }.to_not output('bar').to_stdout }
     # specify { expect { print('foo') }.to_not output(/bar/).to_stdout }
     #
     # # deliberate failures
     # specify { expect { }.to output.to_stdout }
     # specify { expect { }.to output('foo').to_stdout }
     # specify { expect { print('foo') }.to_not output.to_stdout }
     # specify { expect { print('foo') }.to output('bar').to_stdout }
     # specify { expect { print('foo') }.to output(/bar/).to_stdout }
   end

require 'spec_helper'

describe Mongoid::Genesis do

  context 'with the book "The Art of War" written by Sun Tzu' do
    let(:book) { Book.new(:title => 'The Art of War', :author => 'Sun Tzu') }

    subject { book }

    describe "#init_genesis" do
      before { book.init_genesis }

      its('genesis.title') { should be_nil }

      context "genesis.pages" do
        specify { expect { book.genesis.pages }.to raise_error(NoMethodError) }
      end
    end

    describe "#write_and_preserve_attribute" do
      context "when changing title to 'The Art of Peace'" do
        before { book.write_and_preserve_attribute :title, 'The Art of Peace' }

        its(:title) { should eql 'The Art of Peace' }
        its('genesis.title') { should eql 'The Art of War' }

        context "and changing title to 'The Art of Neutrality'" do
          before { book.write_and_preserve_attribute :title, 'The Art of Neutrality' }

          its(:title) { should eql 'The Art of Neutrality' }
          its('genesis.title') { should eql 'The Art of War' }

          context "and rechanging it to 'The Art of War'" do
            before { book.write_and_preserve_attribute :title, 'The Art of War' }

            its(:title) { should eql 'The Art of War' }
            its('genesis.title') { should be_nil }
          end
        end
      end

      context "when changing title to nil" do
        before { book.write_and_preserve_attribute :title, nil }

        its(:title) { should be_nil }
        its('genesis.title') { should eql 'The Art of War' }
      end
    end

    describe "#restore_genesis" do
      context "when changing title to 'The Art of Peace'" do
        before { book.write_and_preserve_attribute :title, 'The Art of Peace' }

        context "and restoring genesis for title" do
          before { book.restore_genesis(:title) }

          its(:title) { should eql 'The Art of War' }
          its('genesis.title') { should be_nil }
        end
      end
    end

    describe "#reverse_genesis" do
      context "when changing title to 'The Art of Peace' and the author to 'Sun Wu'" do
        before { book.write_and_preserve_attribute :title, 'The Art of Peace' }
        before { book.write_and_preserve_attribute :author, 'Sun Wu' }

        context "when reversing genesis" do
          before { book.reverse_genesis }

          its(:title) { should eql 'The Art of War' }
          its(:author) { should eql 'Sun Tzu' }

          context "when making raw change on title to 'The Art of War : Revisited'" do
            before { book.title = 'The Art of War : Revisited' }

            context "and reversing genesis again" do
              before { book.reverse_genesis }

              its(:title) { should eql 'The Art of Peace' }
              its('genesis.title') { should eql 'The Art of War : Revisited' }
            end
          end
        end
      end

    end
  end
end

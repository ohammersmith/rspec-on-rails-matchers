require File.dirname(__FILE__) + '/spec_helper'

class Response
  def body
    return <<-EOF
      <html>
        <form method="post" target="foo">
        </form>
      </html>
    EOF
  end
end

describe 'View matchers' do
  before do
    @response = Response.new
  end

  describe "'have_form_posting_to' matcher" do
    it 'should have the label "have a form submitting via POST to \'<target>\'"' do
      have_form_posting_to(:foo).description.should == "have a form submitting via POST to 'foo'"
    end
  
    # TODO: somehow need to include RSpec::Rails
    it 'should match when the element is present' do
      @response.should have_form_posting_to(:foo)
    end
  end
end
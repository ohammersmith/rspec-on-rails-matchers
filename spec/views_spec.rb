require File.dirname(__FILE__) + '/spec_helper'

class Response
  def content_type; 'text/html'; end
  def body
    return <<-EOF
      <html>
        <form method="post" action="foo">
        </form>
      </html>
    EOF
  end
end

describe 'View matchers' do
  before do
    @response = mock 'response'
    @matcher = mock 'tag matcher'
    @matcher.stub!(:matches?).with(@response).and_return true
  end

  describe "'have_form_posting_to' matcher" do
    it 'should have the label "have a form submitting via POST to \'<target>\'"' do
      have_form_posting_to(:foo).description.should == "have a form submitting via POST to 'foo'"
    end
    
    it 'should wrap have_tag("form[method=post][action=<action>]")' do
      should_receive(:have_tag).with("form[method=post][action=foo]").and_return @matcher
      @matcher.should_receive(:matches?).with(@response).and_return true
      @response.should have_form_posting_to(:foo)
    end
  end

  describe "'have_form_puting_to' matcher" do
    it 'should have the label "have a form submitting via PUT to \'<target>/<id>\'"' do
      have_form_puting_to(:foo, 1).description.should == "have a form submitting via PUT to 'foo/1'"
    end
    
    it 'should wrap have_tag("form[method=post][action=<action>]")' do
      should_receive(:have_tag).with("form[method=post][action=foo/1]").and_return @matcher
      should_receive(:have_tag).with("input[name=_method][type=hidden][value=put]").and_return @matcher
      @response.should have_form_puting_to(:foo, 1)
    end
  end
end
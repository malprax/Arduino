require "spec_helper"
require "Report"
describe Report do
  it "is commented Yohoho" do
    report = Report.new
    report.comment.should == "Yohoho"
  end
   
  
  
end
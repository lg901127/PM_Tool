require 'rails_helper'

RSpec.describe Project, type: :model do
  it "requires a project title" do
    result = Project.new
    result.valid?
    expect(result.errors).to have_key(:title)
  end
  it "requires an unique title" do
    Project.create ({title: "title"})
    result = Project.new ({title: "title"})
    result.valid?
    expect(result.errors).to have_key(:title)
  end
  it "requires a due_date greater than today" do
    result = Project.new({due_date: '2016-01-01'})
    result.valid?
    expect(result.errors).to have_key(:due_date)
  end
end

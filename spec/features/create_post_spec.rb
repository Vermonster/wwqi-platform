require 'spec_helper'

describe "post creation" do
  describe "without authentication" do
    it "only allows a signed in user to create a new post" do
    end
  end

  context "authenticated" do

    describe "Start a new thread button" do
      it "goes to the new post form" do
      end
    end

    describe "question creation" do
      it "creates a new question" do
      end
    end

    describe "discussion creation" do
      it "creates a new discussion", js: true do
      end
    end
  end

  context "with javascript" do
    describe "question creation with uploads" do

      it "creates new uploads", js: true do
      end
    end
  end
end

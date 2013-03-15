# encoding: utf-8

module DemoData
  def self.load
    ActiveRecord::Base.transaction do
      load_users
      load_posts
    end
  end

  private

  def self.load_users
  end

  def self.load_posts
  end
end

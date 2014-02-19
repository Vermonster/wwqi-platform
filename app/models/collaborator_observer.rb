class CollaboratorObserver < ActiveRecord::Observer
  def after_create(collaborator)
    CollaboratorMailer.new_collaboration(collaborator).deliver
  end
end

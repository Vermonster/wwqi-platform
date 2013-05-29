module AssociateItems
  extend ActiveSupport::Concern

  included do
    class_eval do
      extend ActiveModel::Callbacks
      define_model_callbacks :item_association

      def create_or_update_item(item_relation)
        item = Item.find_or_initialize_by_accession_no(item_relation.accession_no)
        item.update_attributes({
          url: item_relation.url,
          thumbnail: item_relation.thumbnail,
          name: item_relation.name
        })
        item
      end

      # Rails can't reflect on polymorphic associations? WTF?
      # Need to fix this
      if self == Contribution
        def associate_item
          if item_relation.new_record? or item_relation.updated? 
            item = create_or_update_item(item_relation)
            item_relation.item = item
            item_relation.itemable = self
          end
        end

        before_save do
          run_callbacks :item_association do
            associate_item
          end
        end
      else
        def associate_items
          self.item_relations.each do |item_relation|
            if item_relation.new_record? or item_relation.updated?
              item = create_or_update_item(item_relation) 
              item_relation.item = item
              item_relation.itemable = self
            end
          end
        end

        before_save do
          run_callbacks :item_association do
            associate_items
          end
        end
      end
    end
  end
end

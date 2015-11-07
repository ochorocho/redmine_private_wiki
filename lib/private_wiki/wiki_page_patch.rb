module PrivateWiki
  module WikiPagePatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        attr_protected :group
        attr_protected :private
        alias_method_chain :visible?, :private_wiki
        #named_scope :nonprivate_only, :conditions => {:private => false}
      end
    end

    module InstanceMethods

      def private_page_visible?(project, user)
#        @wikiGroups = WikiPage.where(:wiki_id => project.wiki.id).where(:title => params[:id])[0]

#         logger.info "############# #{User.current.group_ids} ############### #{!user.nil? && User.current.group_ids.include?(group)} ### "

        group = self.group.split(',').map(&:to_i)
        

        @intersection = User.current.group_ids & group
#        logger.info "### #{@intersection} #### #{group} --- #{User.current.group_ids.map(&:to_i)} #### #{(User.current.group_ids & group).empty?}"
        logger.info "---> #{!@intersection.blank?}"
        
        !user.nil? && user.allowed_to?(:view_private_wiki_pages, project) || !user.nil? && !@intersection.blank?
      end

      def visible_with_private_wiki?(user=User.current)
        allowed = visible_without_private_wiki?(user)
        if allowed and self.private
          return private_page_visible?(project, user)
        end
        allowed
      end

    end
  end
end
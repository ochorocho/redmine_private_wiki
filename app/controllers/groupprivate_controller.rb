class GroupprivateController < ApplicationController
	unloadable
	
	def show

			if params[:id].nil?
                @json = ['status' => 'error']
			else

                @wiki = WikiPage.find(params[:id])                
        	    @groups = Group.find(@wiki.group.split(','))

                @json = [
                    'status' => 'success',
                    'groups' => @groups]
            end
            
            render json: @json
	end

	def write

			if params[:wiki_id].nil? || params[:title].nil?
                @groups = ['status' => 'error']				
			else
                @wiki = WikiPage.where(:wiki_id => params[:wiki_id]).where(:title => params[:title])
                @wiki[0].group = params[:groups]
                @wiki[0].save
                
                @groupAll = Group.all
                @groups = [
                    'status' => 'success',
                    'id' => @wiki[0]['id'],
                    'write' => @wiki,
                    'title' => params[:title],
                    'wiki_id' => params[:wiki_id],
                    'groups' => params[:groups]]
			end 



		render json: @groups
	end

	def showform

        @wikiGroups = WikiPage.find(params[:id])
        if @wikiGroups.group
            @groupPerm = Group.find(@wikiGroups.group.split(','))
        end
        
        @groupAll = Group.all
        @checkboxed = []
        for group in @groupAll
        	if @wikiGroups.group
                if @groupPerm.include?(group)
                	@checkboxed << ['checked' => true, 'name' => group.name, 'id' => group.id]
                else
                	@checkboxed << ['checked' => false, 'name' => group.name, 'id' => group.id]
                end
            else
                @checkboxed << ['checked' => false, 'name' => group.name, 'id' => group.id]
            end
        end

		if params[:id].nil?
            @json = ['status' => 'error']
		else

            @wiki = WikiPage.find(params[:id])                
    	    @groups = Group.find(@wiki.group.split(','))

            @json = [
                'status' => 'success',
                'groups' => @checkboxed]
        end
        
        render json: @json
	end

end

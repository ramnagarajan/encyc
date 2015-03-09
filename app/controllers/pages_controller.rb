class PagesController < ApplicationController
	def read
		if Page.exists?(:page => params['pagename'])
		b=Page.find_by(page: params['pagename'])
		
		pg=Section.count(page_id: b.page_id)
		 HttpPermission.cors_post_permission(headers)
		a=Section.where(page_id: b.page_id).order("created_at ASC").take(pg)
		render :json => { page: a ,content: b}, :status =>200
		else
		 HttpPermission.cors_post_permission(headers)
		render :json => "not found", :status => 201
		
	end
	end
	def userdisp
		
		@q = User.all
		 HttpPermission.cors_post_permission(headers)
render :json => @q, :status => 200

	end 
	def userdel
	d=User.find_by(:username =>params['name'])
    d.destroy
HttpPermission.cors_post_permission(headers)
    render :text =>"sucessfully deleted the user", :status => 200

	end
	def pagedisp
 @p = Page.all
HttpPermission.cors_post_permission(headers)
render :json => @p, :status => 200
 end
 def pagedel
 k=Page.find_by(:page =>params['pname'])
 b=Revhistory.find_by(:page_id => k.page_id)
 c=Section.find_by(:page_id => k.page_id)
 k.destroy
 b.destroy
 c.destroy
HttpPermission.cors_post_permission(headers)
 render :text =>"sucessfully deleted the page", :status => 200

 end
	def cate
		
		 q = Page.select(:category_id).distinct
		 render :json => q
	end
	def artic
		q = Page.select(:page).where(:category_id => params['cat'])
		render :json => q
	end
	def random
		c=Page.pluck().shuffle[0]
		a1=c[3]
		b=Page.find_by(page_id: a1)
		pg=Section.count(page_id: b.page_id)
		
			 HttpPermission.cors_post_permission(headers)
		a=Section.where(page_id: b.page_id).order("created_at ASC").take(pg)
		render :json => { page: a ,content: b}, :status =>200
		
	end
	def latest
		b=Page.last
		pg=Section.count(page_id: b.page_id)
		
			 HttpPermission.cors_post_permission(headers)
		a=Section.where(page_id: b.page_id).order("created_at ASC").take(pg)
		render :json => { page: a ,content: b}, :status =>200
		
	end
	def updates
				b=Section.find_by(s_name: params['sname'],page_id: params['pageid'])
				HttpPermission.cors_post_permission(headers)
				render :json => { sname: b.s_name ,content: b.section}, :status =>200
	end
	 def update1
    tn=User.find_by(token:"5678a3b3af02fbcd9b7d249e54d40246")
    @a=Revhistory.where(s_name: params['sname'],page_id: params['pageid']).order("created_at DESC").first
 #render :json => @a
     rn = @a.revno + 1
     ch = params['scontent'].length - @a.section.length

      b=Section.find_by(s_name:params['sname'],page_id: params['pageid'])
       b.update(section: params['scontent'])
 
  rh = Revhistory.new( :page_id => b.page_id, :contributor => tn.username, :s_name => b.s_name, :section => b.section,:ip =>request.remote_ip, :lines => ch, :revno => rn)
  if rh.save
      HttpPermission.cors_post_permission(headers)

       render :json => {:token => rh}, :status =>200
     else
      HttpPermission.cors_post_permission(headers)

           render :json => {:message => "something went wrong" }, :status =>201
     end
      
 end
def rh
		pg=Revhistory.all.where(:page_id => params['pid'], :s_name => params['sname'])
HttpPermission.cors_post_permission(headers)
		
render :json => pg, :status => 200
		
	end
def und
	 tn=User.find_by(token:"5678a3b3af02fbcd9b7d249e54d40246")
	 @a=Revhistory.where(s_name: params['sname'], :page_id => params['pid']).order("created_at DESC").first
	 rn = @a.revno - 1
	 @b=Revhistory.where(s_name: params['sname'], :page_id => params['pid'], revno: rn).order("created_at DESC").first
	 @a.destroy
	 @c=Section.where(s_name: params['sname'], :page_id => params['pid']).order("created_at DESC").first
	 @c.update(section: @b.section)
HttpPermission.cors_post_permission(headers)

render :json => @b, :status => 200
end

	require 'securerandom'

	def create1
	end
	def save	
     random_string = SecureRandom.hex
    tn=User.find_by(token:"5678a3b3af02fbcd9b7d249e54d40246")
    if Page.exists?(:page => params['page'])
    b=Page.find_by(:page => params['page'])
    #@page = Page.new(:page_id => b.page_id, :page => params["page"], :category_id => b.category_id, :contributor => tn.username)
    @section = Section.new(:page_id => b.page_id, :s_name => params["sname"], :section => params['scontent'])
    @rh = Revhistory.new(:page_id => b.page_id,:revno => 1, :ip=>request.remote_ip, :contributor => tn.username, :s_name => params["sname"], :section => params['scontent'], :lines => params['scontent'].length)
	if @rh.save && @section.save 

      render :json => {:token => @rh}, :status =>200
    else
          render :json => {:message => "something went wrong" }, :status =>201
    end
	else
    @page = Page.new(:page_id => random_string, :page => params["page"], :category_id => params['cat'], :contributor => tn.username)
    @section = Section.new(:page_id => random_string, :s_name => params["sname"], :section => params['scontent'])
    @rh = Revhistory.new(:page_id => random_string,:revno => 1, :ip=>request.remote_ip, :contributor => tn.username, :s_name => params["sname"], :section => params['scontent'], :lines => params['scontent'].length)
	
	if @page.save && @rh.save && @section.save 

      render :json => {:token => @rh}, :status =>200
    else
          render :json => {:message => "something went wrong" }, :status =>201
    end
	end
    
	end
end

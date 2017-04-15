class UserMailer < ApplicationMailer
	def converted_email(email, contest, base_url)
        @url  =  base_url + "/sites/" + contest
    	mail(to: email, subject: 'Tu voz ya está participando!')
	end
end

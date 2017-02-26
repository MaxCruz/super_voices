class UserMailer < ApplicationMailer
	default from: 'supervoices7@gmail.com'

	def converted_email(voice, base_url)
		@voice = voice
        @url  =  base_url + "/sites/" + voice.contest.url
    	mail(to: @voice.email, subject: 'Tu voz ya está participando!')
	end
end

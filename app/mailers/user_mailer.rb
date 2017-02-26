class UserMailer < ApplicationMailer
	default from: 'supervoices7@gmail.com'

	def converted_email(voice)
		@voice = voice
		@url  = 'http://google.com'
    	mail(to: @voice.email, subject: 'Tu voz ya está participando!')
	end
end

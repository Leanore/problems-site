Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '466429130044458', 'fafb03b7d64137a05bc1584210fe7b11'
  provider :github, 'f47d437c2383962e40e7', '0095f61c274420e1f8ab968c98e582ab80c5b8c4'
  provider :twitter, 'jCanwIJcluj2oasy7i0Ew', 'ydfD9Rred1Sn9byY0EWVRWiaIIVhh7wTCLr3peBsI0'
end




require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    #
    # Authenticate to TwitCasting via OAuth and retrieve basic user information.
    # Usage:
    #    use OmniAuth::Strategies::Twitcasting, 'consumerkey', 'consumersecret'
    #
    class Twitcasting < OmniAuth::Strategies::OAuth2
      AUTHENTICATION_PARAMETERS = %w(state)
      BASE_URL = 'https://apiv2.twitcasting.tv'

      option :name, 'twitcasting'

      option :client_options, {
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/access_token',
        :site => BASE_URL
      }

      option :authorize_options, AUTHENTICATION_PARAMETERS

      uid do
        raw_info['user']['id']
      end

      info do
        {
          :name => raw_info['user']['name'],
          :image => raw_info['user']['image']
        }
      end

      def raw_info
        @raw_info ||= access_token.get(BASE_URL + '/verify_credentials').parsed
      end

      # Over-ride callback_url definition to maintain
      # compatability with omniauth-oauth2 >= 1.4.0
      #
      # See: https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end

      # Hook useful for appending parameters into the auth url before sending
      # to provider.
      def request_phase
        super
      end

      # Hook used after response with code from provider. Used to prep token
      # request from provider.
      def callback_phase
        super
      end

      def authorize_params
        super.tap do |params|
          AUTHENTICATION_PARAMETERS.each do |v|
            params[v.to_sym] = request.params[v] if request.params[v]
          end
        end
      end
    end
  end
end

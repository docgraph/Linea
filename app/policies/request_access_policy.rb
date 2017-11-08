# Copyright© 2017 Merck Sharp & Dohme Corp. a subsidiary of Merck & Co., Inc., Kenilworth, NJ, USA.  Licensed under the Apache License, Version 2.0 (the "License");    you may not use this file except in compliance with the License.    You may obtain a copy of the License at       http://www.apache.org/licenses/LICENSE-2.0     Unless required by applicable law or agreed to in writing, software    distributed under the License is distributed on an "AS IS" BASIS,    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    See the License for the specific language governing permissions and    limitations under the License. 
class RequestAccessPolicy
  attr_reader :user, :request_access_id

  def initialize(user, request_access_id)
    @user = user
    @request_access_id = request_access_id
  end

  def resolved?
    resolved_request_access.status != 'waiting'
  end

  private

  def resolved_request_access
    RequestAccess.find(request_access_id)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.joins(:dataset).where(datasets: { owner_id: user.id }).where(status: '0')
    end
  end
end
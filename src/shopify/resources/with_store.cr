class Shopify::WithStore(T)
  def initialize(@store : Store); end

  def new_headers
    HTTP::Headers{
      "X-Shopify-Access-Token" => @store.access_token,
      "Content-Type"           => "application/json",
    }
  end

  forward_missing_to T

  def all
    T.all(@store.shop, new_headers).tap &.store=(@store)
  end

  def all(page : String? = nil, &block : T ->)
    T.all(@store.shop, page, new_headers, &block).tap &.store=(@store)
  end

  def find(id)
    T.find(id, @store.shop, new_headers).tap &.store=(@store)
  end

  def create(body : String)
    T.create(body, @store.shop, new_headers).tap &.store=(@store)
  end
end

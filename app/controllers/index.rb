require 'vacuum'

get '/' do
	"hello world"
	request = Vacuum.new

	request.configure(
    aws_access_key_id:
    aws_secret_access_key:
    associate_tag:
)




output = request.item_search(
  query: {
    'Keywords' => 'R2D2',
    'SearchIndex' => 'All',
    'ItemPage' => '1',
    'ItemSearch.Shared.ResponseGroup' => 'Large',
  }
)

p output.to_h


end

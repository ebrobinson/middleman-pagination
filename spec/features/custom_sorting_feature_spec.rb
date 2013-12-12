require 'spec_helper'

describe "Pagination with custom sorting", :feature do
  it "produces pages for a set of resources with custom sorting" do
    run_site 'recipes' do
      activate :pagination do
        pageable_resource :recipes do |resource|
          resource.path.start_with?('recipes')
        end
      end
    end

    visit '/'
    find_on_page 'Showing 2 per page'
    find_on_page 'First page: /'
    find_on_page 'Last page: /pages/4.html'

    find_on_page 'Sandwich'
    find_on_page 'Yeti'
    find_on_page 'Page 1 of 4'
    find_on_page 'Prev page: none'
    find_on_page 'Next page: /pages/2.html'

    visit '/pages/2.html'
    find_on_page 'Waffles'
    find_on_page 'Mead'
    find_on_page 'Page 2 of 4'
    find_on_page 'Prev page: /'
    find_on_page 'Next page: /pages/3.html'

    visit '/pages/3.html'
    find_on_page 'Cake'
    find_on_page 'Gelato'
    find_on_page 'Page 3 of 4'
    find_on_page 'Prev page: /pages/2.html'
    find_on_page 'Next page: /pages/4.html'

    visit '/pages/4.html'
    find_on_page 'Bacon'
    find_on_page 'Page 4 of 4'
    find_on_page 'Prev page: /pages/3.html'
    find_on_page 'Next page: none'
  end
end

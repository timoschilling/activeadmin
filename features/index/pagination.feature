Feature: Index Pagination

  Background:
  Scenario: Viewing index when one page of resources exist
    Given an index configuration of:
    """
      ActiveAdmin.register_resource Post
    """
    Given 20 posts exist
    When I am on the index page for posts
    Then I should see "Displaying all 20 Posts"
    And I should not see pagination

  Scenario: Viewing index when multiple pages of resources exist
    Given an index configuration of:
    """
      ActiveAdmin.register_resource Post
    """
    Given 31 posts exist
    When I am on the index page for posts
    Then I should see pagination with 2 pages

  Scenario: Viewing index with a custom per page set
    Given an index configuration of:
    """
      ActiveAdmin.register_resource Post do
        config.per_page = 2
      end
    """
    Given 3 posts exist
    When I am on the index page for posts
    Then I should see pagination with 2 pages
    And I should see "Displaying Posts 1 - 2 of 3 in total"

  Scenario: Viewing index with pagination disabled
    Given an index configuration of:
    """
      ActiveAdmin.register_resource Post do
        config.paginate = false
      end
    """
    Given 31 posts exist
    When I am on the index page for posts
    Then I should not see pagination

    Scenario: Viewing index with pagination_total set to false
      Given an index configuration of:
      """
        ActiveAdmin.register_resource Post do
          index :pagination_total => false do
          end
        end
      """
      Given 100 posts exist
      When I am on the index page for posts
      Then I should see pagination with 4 pages
      Then I should see "Displaying Posts 1 - 30"
      And I should not see "Displaying Posts 1 - 30 of 100 in total"


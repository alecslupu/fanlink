# Feature: Deleting a category (V3)
#     Scenario: Soft Delete a category
#         Given A category is created
#         When a category is soft deleted
#         Then category should return deleted as true

#     Scenario: Soft Delete a category associated with a post
#         Given A category is created
#         And the category is attached to a post
#         When a category is soft deleted
#         Then the post should not have a category

#     Scenario: Destroy a category
#         Given A category is created
#         When a category is deleted
#         Then category should return nil

#     Scenario: Destroying a category associated with a post
#         Given A category is created
#         And the category is attached to a post
#         When a category is deleted
#         Then the post should not have a category

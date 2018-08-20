###TODO

- Cleanup returned json data for app and portal
- ~~Finish migrations for account termination and unlocks_at timestamp~~
- Add filters and pagination to list endpoints
- Add tests using generated api data
- ~~Finish caching~~
- Add tests for event listeners
- Test cronjobs with delayed job
- ~~Cleanup apidocs repo~~
- ~~Generate postman collections from API data~~
- Fix docker init script
- Polls on posts (Started)
- Venues (Migrations done)
- Cole:
  * ~~Badges endpoint needs pagination~~
  * Rewards endpoint needs pagination
  * ~~Merchandise endpoint needs pagination~~
  * Destroy a person
  * Create a level endpoint with pagination
  * Edit a level endpoint
  * Destroy a level endpoint
- ~~Use Rollbar for http status errors~~
- Server side vue
- Redis for caching (On Staging)
- Review database indexes
- App/Portal Separation
  * Show hidden messages for the portal
  * ~~Show future posts for portal~~
- ~~Get user block list~~


####JSON Cleanup and other changes
- Badge Actions
    * Return badge name and ID instead of entire badge object
- Badges
    * Reduce index json data.
- Blocks
    * Return ID and username instead of entire person object
- Events
    * Reduce index json data.
- Followings
    * Return ID and username instead of entire person object
- Levels
    * Reduce index json data.
- Merchandise
    * Reduce index json data.
- Mentions
    * Get a mention list for current user since last log in
- Message Reports
    * Reduce index json data.
- Messages
    * Reduce index json data.
- Password Resets
    *
- People
    * Reduce index json data.
    * Track last login
    * Track IP? (Security feature. Similar to Googles verification)
    * 2FA with authenticator?
- Post Comment Reports
    *
- Post Comments
    *
- Post Reactions
    *
- Posts
    * Reduce index json data.
- Recommended People
    *
- Recommended Posts
    * Reduce index json data.
- Relationships
    *
- Room Memberships
    *
- Rooms
    *
- Sessions
    *

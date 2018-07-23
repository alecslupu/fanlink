# Reward System

#### Description

This is to help with the changes that went in regarding the badges, levels, quests and adding in a reward system

#### Changes

##### Badges

Biggest changes are with badges. They return more data and accept fewer fields in the table. I tried to keep the original data how it was, but the return data for badges is now:

```json
"badge": {
                "id": "11",
                "name": "Follow 250 People",
                "internal_name": "follow_250",
                "description": "To follow a user visit their profile and tap the \"Follow\" button.",
                "picture_url": "https://s3.us-east-1.amazonaws.com/fanlink-development/admin/badges/pictures/000/000/011/optimal/a5c51ac32163d5b75e2d1188421accefa7a7c319.png?1519188560",
                "action_type_id": 11,
                "action_requirement": 250,
                "point_value": 250,
                "reward": {
                    "id": 11,
                    "product_id": 1,
                    "name": "Follow 250 People",
                    "internal_name": "follow_250",
                    "reward_type": "badge",
                    "reward_type_id": 11,
                    "series": null,
                    "completion_requirement": 250,
                    "points": 250,
                    "status": "active",
                    "deleted": false,
                    "created_at": "2018-06-22T16:30:29.828Z",
                    "updated_at": "2018-06-22T16:30:29.828Z"
                },
                "badges_awarded": [
                    {
                        "id": 1,
                        "person_id": 1,
                        "reward_id": 1,
                        "source": "migration",
                        "created_at": "2018-06-22T16:30:52.261Z",
                        "updated_at": "2018-06-22T16:30:52.261Z",
                        "deleted": false
                    }
                ],
                "assigned_rewards": [
                    {
                        "id": 11,
                        "reward_id": 11,
                        "assigned_id": 8,
                        "assigned_type": "ActionType",
                        "max_times": 1,
                        "created_at": "2018-06-22T16:30:29.839Z",
                        "updated_at": "2018-06-22T16:30:29.839Z"
                    }
                ]
            }
```

The reward object is what gives the badge. This links the badge to what contributes to unlocking the badge.

The other new object is assigned_rewards. These are what contribute to the action/completion requirement.

badges_awarded has been changed to return the rewards a person has aquired with the type of badge.

##### Users

The returned data for users has also changed.

Snippet:

```json
{
    "person": {
        "id": "1",
        "username": "admin",
        "name": "Admin User",
        "gender": "unspecified",
        "city": null,
        "country_code": null,
        "birthdate": null,
        "picture_url": null,
        "product_account": false,
        "recommended": false,
        "chat_banned": false,
        "designation": null,
        "following_id": null,
        "badge_points": 2520,
        "role": "super_admin",
        "level": null,
        "do_not_message_me": false,
        "pin_messages_from": false,
        "auto_follow": false,
        "num_followers": 0,
        "num_following": 0,
        "facebookid": null,
        "facebook_picture_url": null,
        "created_at": "2018-06-22T15:31:54Z",
        "updated_at": "2018-06-22T15:31:54Z",
        "email": "admin@example.com",
        "product": {
            "internal_name": "admin",
            "id": 1,
            "name": "Admin"
        },
        "level_progress": [
            {
                "id": 1,
                "points": {
                    "badge": 25
                },
                "total": 25
            }
        ],
        "rewards": [
            {
                "id": 1,
                "source": "reward",
                "deleted": false,
                "awarded": {
                    "id": 1,
                    "product_id": 1,
                    "name": "Chat for 60 Minutes",
                    "internal_name": "chat_60",
                    "reward_type": "badge",
                    "reward_type_id": 1,
                    "series": null,
                    "completion_requirement": 10,
                    "points": 1000,
                    "status": "active",
                    "deleted": false,
                    "created_at": "2018-06-22T15:32:34.930Z",
                    "updated_at": "2018-06-22T15:32:34.930Z"
                }
            }
        ]
    }
}
```

The person json returns all the rewards they have been awarded as well as their current level progress. The points object contains all the sources that points were recieved from.

The source field on rewards can be reward, migration or the email address of the user that awarded the reward.

## **API end points**

### **App**

-   GET /badges[?person_id=1]

    -   Now takes an optional person_id parameter
    -   Returns all the badges with badges_awarded being null without the parameter
    -   With the person id, each badge will show the badges_awarded object if the user has unlocked it, null if not.

-   POST /[quests, quest_activities, steps, action_types]/complete
    -   Requires reward_complete[reward_id] value to be sent.
    -   The multiple end points are used to determine where the reward is coming from for tracking the source.

### **Portal**

-   Crud for action types
    -   This is locked to super admins. Currently untested
-   Crud for badges
    -   This is locked to admins. Currently untested
-   Crud for rewards
    -   This is locked to admins.
    -   Endpoints are available. GET/POST/UPDATE/DELETE /rewards/[:id]
    -   Available Fields
        -   reward[name]: **required**
        -   reward[internal_name]: Alphanumeric and underscores **required**
        -   reward[reward_type]:[badge, url, coupon] **required**
        -   reward[reward_type_id]: id of the type. **required**
        -   reward[series]: _optional_
        -   reward[completion_requirement]:Defaults to 1 _optional_
        -   reward[points]: Defaults to 0 _optional_
        -   reward[status]: active, inactive. Defaults to active _optional_
-   Assigned Rewards

    -   Nothing for this yet. Still trying to figure out how to best handle this
    -   Will be most likely passed with each respective type. So with quests, steps, quest activties, action types

## Reward System

System is designed to be expandable. Supports attaching multiple sources of reward completion. It also supports having different reward types.

It adds level and reward progress tracking with sources as well as a limit on how many times a source can apply to a reward.

This system replaces the current badge action and badge award tables.

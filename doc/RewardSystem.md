# Reward System

#### Description

This is to help with the changes that went in regarding the badges, levels, quests and adding in a reward system

#### Changes

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

## API end points

-   GET /badges[?person_id=1]

    -   Now takes an optional person_id parameter
    -   Returns all the badges with badges_awarded being null without the parameter
    -   With the person id, each badge will show the badges_awarded object if the user has unlocked it, null if not.

-   POST /[quests, quest_activities, steps, action_types]/complete
    -   Requires reward_complete[reward_id] value to be sent.
    -   The multiple end points are used to determine where the reward is coming from for tracking the source.

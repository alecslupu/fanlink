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
                "picture_url": "https://s3.us-east-1.amazonaws.com/fanlink-development/admin/badges/pictures/000/000/011/original/3caa105d3da36353990728052918a08087508832.png?1519188560",
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
                    "created_at": "2018-06-22T13:00:57.879Z",
                    "updated_at": "2018-06-22T13:00:57.879Z"
                },
                "badges_awarded": null,
                "assigned_rewards": [
                    {
                        "id": 11,
                        "reward_id": 11,
                        "assigned_id": 8,
                        "assigned_type": "ActionType",
                        "max_times": 1,
                        "created_at": "2018-06-22T13:00:57.891Z",
                        "updated_at": "2018-06-22T13:00:57.891Z"
                    }
                ]
            }
```

The reward object is what gives the badge.

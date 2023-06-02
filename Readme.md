
https://sequelize.org/docs/v6/advanced-association-concepts/eager-loading/

```
const tasks = await Task.findAll({ include: User });

or all elements
const users = await User.findAll({ include: Task });

User.findAll({
  include: {
    model: Tool,
    as: 'Instruments'
    where: {
      size: {
        [Op.ne]: 'small'
      }
    }
  }
});

```
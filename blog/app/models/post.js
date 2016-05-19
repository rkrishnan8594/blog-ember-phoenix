import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr('string'),
  author: DS.attr('string'),
  summary: DS.attr('string'),
  comments: DS.hasMany('comment', {async: true})
});

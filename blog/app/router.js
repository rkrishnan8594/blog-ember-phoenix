import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('post', { path: '/posts/:post_id' }, function() {
    this.route('comments', function() {
      this.route('new');
    });
  });
  this.route('edit', {path: '/posts/:post_id/edit'});
  this.route('new', {path: '/posts/new'});
  this.route('posts', { path: '/' });
  this.route('posts');
});

export default Router;

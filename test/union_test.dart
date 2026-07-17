import 'package:test/test.dart';
import 'package:dart_easy_json/easy_json.dart';
import 'package:dart_easy_json/src/easy_issue.dart';
import 'models/test_models.dart';
import 'models/test_models.easy.dart';

void main() {
  group('EasyUnion Serialization', () {
    test('fromJson routes to the correct subclass', () {
      final jsonText = {'type': 'text', 'author': 'John', 'content': 'Hello'};
      final post = PostJson.fromJson(jsonText);

      expect(post, isA<TextPost>());
      expect((post as TextPost).content, 'Hello');
    });

    test('fromJsonSafe handles fallback and reports issue', () {
      final jsonPdf = {'type': 'pdf'};
      final issues = <EasyIssue>[];
      final post = PostJson.fromJsonSafe(jsonPdf, onIssue: issues.add);

      expect(post, isA<UnknownPost>());
      expect(issues.isNotEmpty, true);
      expect(issues.first.code, 'unknown_union_type');
    });

    test('validate returns issues for unknown type even with fallback', () {
      final jsonPdf = {'type': 'pdf'};
      final issues = PostJson.validate(jsonPdf);
      
      expect(issues.isNotEmpty, true);
      expect(issues.first.code, 'unknown_union_type');
    });

    test('toJson delegates to the child subclass', () {
      final post = VideoPost(author: 'Jane', videoUrl: 'http://video');
      final json = postToJson(post);
      
      expect(json['author'], 'Jane');
      expect(json['videoUrl'], 'http://video'); // Case style in the lib
    });

    test('List<Post> fromJsonSafe parses all items correctly', () {
      final jsonFeed = {
        'posts': [
          {'type': 'text', 'author': 'John', 'content': 'Hi'},
          {'type': 'pdf', 'author': 'Hacker'},
          {'type': 'video', 'author': 'Jane', 'videoUrl': 'http'}
        ]
      };

      final issues = <EasyIssue>[];
      final feed = Feed.fromJsonSafe(jsonFeed, onIssue: issues.add);

      expect(feed.posts.length, 3);
      expect(feed.posts[0], isA<TextPost>());
      expect(feed.posts[1], isA<UnknownPost>());
      expect(feed.posts[2], isA<VideoPost>());
    });
  });
}

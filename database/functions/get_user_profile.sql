CREATE OR REPLACE FUNCTION get_user_profile(user_uuid uuid)
RETURNS json AS $$
DECLARE
    ideas_submitted_count text;
    votes_given_count text;
    votes_received_count text;
    user_ideas json;
    result json;
BEGIN
    -- Count ideas submitted by user
    SELECT COALESCE(COUNT(*)::text, '0') INTO ideas_submitted_count
    FROM ideas 
    WHERE author = user_uuid;
    
    -- Count votes given by user
    SELECT COALESCE(COUNT(*)::text, '0') INTO votes_given_count
    FROM idea_votes 
    WHERE user_id = user_uuid;
    
    -- Count total votes received on user's ideas
    SELECT COALESCE(SUM(i.votes)::text, '0') INTO votes_received_count
    FROM ideas i 
    WHERE i.author = user_uuid;
    
    -- Get user's ideas as JSON array
    SELECT COALESCE(
        json_agg(
            json_build_object(
                'id', i.id,
                'title', i.title,
                'description', i.description,
                'category', i.category,
                'author', i.author,
                'ai_rating', i.ai_rating,
                'ai_feedback', i.ai_feedback,
                'votes', i.votes,
                'has_voted', i.has_voted,
                'created_at', i.created_at
            )
            ORDER BY i.created_at DESC
        ),
        '[]'::json
    ) INTO user_ideas
    FROM ideas i
    WHERE i.author = user_uuid;
    
    -- Build the final result object
    SELECT json_build_object(
        'idead_submitted', ideas_submitted_count,
        'votes_given', votes_given_count,
        'votes_received', votes_received_count,
        'myIdeas', user_ideas
    ) INTO result;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;